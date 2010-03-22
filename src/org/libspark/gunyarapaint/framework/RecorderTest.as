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
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 123, 321, 16);
            Assert.assertStrictlyEquals(123, recorder.width);
            Assert.assertStrictlyEquals(321, recorder.height);
        }
        
        [Test(async)]
        public function commitCommand():void
        {
            var commands:CommandContext = new CommandContext();
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = new Recorder(bytes, 1, 1, commands);
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
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 1, 1, 16);
            var undo:UndoStack = recorder.undoStack;
            undo.addEventListener(UndoEvent.UNDO, onUndo);
            undo.addEventListener(UndoEvent.REDO, onRedo);
            undo.addEventListener(UndoEvent.PUSH, onPushUndo);
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
            var undo:UndoStack = UndoStack(event.target);
            Assert.assertStrictlyEquals(UndoEvent.UNDO, event.type);
            Assert.assertStrictlyEquals(0, undo.undoCount);
            Assert.assertStrictlyEquals(1, undo.redoCount);
        }
        
        private function onRedo(event:UndoEvent):void
        {
            var undo:UndoStack = UndoStack(event.target);
            Assert.assertStrictlyEquals(UndoEvent.REDO, event.type);
            Assert.assertStrictlyEquals(1, undo.undoCount);
            Assert.assertStrictlyEquals(0, undo.redoCount);
        }
        
        private function onPushUndo(event:UndoEvent):void
        {
            var undo:UndoStack = UndoStack(event.target);
            Assert.assertStrictlyEquals(UndoEvent.PUSH, event.type);
            Assert.assertStrictlyEquals(1, undo.undoCount);
            Assert.assertStrictlyEquals(0, undo.redoCount);
        }
    }
}