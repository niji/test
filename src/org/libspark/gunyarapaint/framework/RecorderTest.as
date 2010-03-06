package org.libspark.gunyarapaint.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.events.CommandEvent;
    import org.libspark.gunyarapaint.framework.events.UndoEvent;

    public class RecorderTest
    {
        [Test]
        public function prepare():void
        {
            m_recorder.prepare(123, 321, 16);
            Assert.assertStrictlyEquals(123, m_recorder.width);
            Assert.assertStrictlyEquals(321, m_recorder.height);
        }
        
        [Test(async)]
        public function commitCommand():void
        {
            var command:ICommand = new FakeCommand();
            m_commands.registerCommand(command);
            m_recorder.addEventListener(CommandEvent.COMMITTED, onCommitCommand);
            m_recorder.commitCommand(FakeCommand.ID, command);
            Assert.assertTrue(FakeCommand.didExecute);
            Assert.assertTrue(FakeCommand.didWrite);
            Assert.assertEquals(command, FakeCommand.writeArgument);
        }
        
        [Test(async)]
        public function undo():void
        {
            m_recorder.addEventListener(UndoEvent.UNDO, onUndo);
            m_recorder.addEventListener(UndoEvent.REDO, onRedo);
            m_recorder.addEventListener(UndoEvent.PUSH, onPushUndo);
            m_recorder.prepare(1, 1, 1);
            m_recorder.pushUndo();
            m_recorder.undo();
            m_recorder.redo();
        }
        
        private function onCommitCommand(event:CommandEvent):void
        {
            Assert.assertEquals(FakeCommand.ID, event.command.commandID);
        }
        
        private function onUndo(event:UndoEvent):void
        {
            Assert.assertStrictlyEquals(UndoEvent.UNDO, event.type);
            Assert.assertStrictlyEquals(0, event.undoCount);
            Assert.assertStrictlyEquals(1, event.redoCount);
        }
        
        private function onRedo(event:UndoEvent):void
        {
            Assert.assertStrictlyEquals(UndoEvent.REDO, event.type);
            Assert.assertStrictlyEquals(1, event.undoCount);
            Assert.assertStrictlyEquals(0, event.redoCount);
        }
        
        private function onPushUndo(event:UndoEvent):void
        {
            Assert.assertStrictlyEquals(UndoEvent.PUSH, event.type);
            Assert.assertStrictlyEquals(1, event.undoCount);
            Assert.assertStrictlyEquals(0, event.redoCount);
        }
        
        [Before]
        public function before():void
        {
            m_commands = new CommandCollection();
            m_bytes = new ByteArray();
            m_recorder = new Recorder(m_bytes, m_commands);
        }
        
        private var m_bytes:ByteArray;
        private var m_commands:CommandCollection;
        private var m_recorder:Recorder;
    }
}