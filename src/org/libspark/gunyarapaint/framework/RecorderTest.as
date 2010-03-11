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
            var recorder:Recorder = Recorder.create(123, 321, 16);
            Assert.assertStrictlyEquals(123, recorder.width);
            Assert.assertStrictlyEquals(321, recorder.height);
        }
        
        [Test(async)]
        public function commitCommand():void
        {
            var commands:CommandContext = new CommandContext();
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = new Recorder(1, 1, bytes, commands);
            var command:ICommand = new FakeCommand();
            commands.registerCommand(command);
            recorder.addEventListener(CommandEvent.COMMITTED, onCommitCommand);
            recorder.commitCommand(FakeCommand.ID, command);
            Assert.assertTrue(FakeCommand.didExecute);
            Assert.assertTrue(FakeCommand.didWrite);
            Assert.assertEquals(command, FakeCommand.writeArgument);
        }
        
        [Test(async)]
        public function undo():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 16);
            recorder.addEventListener(UndoEvent.UNDO, onUndo);
            recorder.addEventListener(UndoEvent.REDO, onRedo);
            recorder.addEventListener(UndoEvent.PUSH, onPushUndo);
            recorder.pushUndo();
            recorder.undo();
            recorder.redo();
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
    }
}