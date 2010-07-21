package org.libspark.gunyarapaint.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;
    import org.libspark.gunyarapaint.framework.commands.CompositeCommand;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.events.CommandEvent;
    import org.libspark.gunyarapaint.framework.events.UndoEvent;

    public class RecorderTest
    {
        
        [Test(description="widthとheightが設定されること")]
        public function shouldSetWidthAndHeightAfterCreate():void
        {
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 123, 321, 16);
            Assert.assertStrictlyEquals(123, recorder.width);
            Assert.assertStrictlyEquals(321, recorder.height);
        }
        
        [Test(description="bytesでコピーを取ることが出来ること")]
        public function shouldCopyBytes():void
        {
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 123, 321, 16);
            var length:uint = recorder.newBytes().length;
            recorder.commitCommand(CompositeCommand.ID, {});
            Assert.assertEquals(34, length);
        }
        
        [Test(async, description="commitCommandでコマンド及びCOMMITTEDイベントが実行されること")]
        public function shouldDispatchCommittedEvent():void
        {
            var commands:CommandContext = new CommandContext();
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = new Recorder(bytes, 1, 1, commands);
            var command:ICommand = new FakeCommand();
            commands.registerCommand(command);
            recorder.addEventListener(CommandEvent.COMMITTED,
                Async.asyncHandler(this, onCommitCommand, 100));
            recorder.commitCommand(FakeCommand.ID, command);
            Assert.assertTrue(FakeCommand.didExecute);
            Assert.assertTrue(FakeCommand.didWrite);
            Assert.assertEquals(command, FakeCommand.writeArgument);
        }
        
        [Test(async, description="巻き戻しを追加するとUndoEvent.PUSHが呼ばれること")]
        public function shouldDispatchPushEventAfterPushUndo():void
        {
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 1, 1, 16);
            recorder.undoStack.addEventListener(UndoEvent.PUSH,
                Async.asyncHandler(this, onPushUndo, 100));
            recorder.pushUndo();
        }
        
        [Test(async, description="巻き戻しされるとUndoEvent.UNDOが呼ばれること")]
        public function shouldDispatchUndoEventAfterUndo():void
        {
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 1, 1, 16);
            recorder.undoStack.addEventListener(UndoEvent.UNDO,
                Async.asyncHandler(this, onUndo, 100));
            recorder.pushUndo();
            recorder.undo();
        }
        
        [Test(async, description="やり直しされるとUndoEvent.REDOが呼ばれること")]
        public function shouldDispatchRedoEventAfterRedo():void
        {
            var bytes:ByteArray = new ByteArray();
            var recorder:Recorder = Recorder.create(bytes, 1, 1, 16);
            recorder.undoStack.addEventListener(UndoEvent.REDO,
                Async.asyncHandler(this, onRedo, 100));
            recorder.pushUndo();
            recorder.undo();
            recorder.redo();
        }
        
        private function onCommitCommand(event:CommandEvent, ignore:Object):void
        {
            Assert.assertEquals(FakeCommand.ID, event.command.commandID);
        }
        
        private function onUndo(event:UndoEvent, ignore:Object):void
        {
            var undo:UndoStack = UndoStack(event.target);
            Assert.assertStrictlyEquals(UndoEvent.UNDO, event.type);
            Assert.assertStrictlyEquals(0, undo.undoCount);
            Assert.assertStrictlyEquals(1, undo.redoCount);
        }
        
        private function onRedo(event:UndoEvent, ignore:Object):void
        {
            var undo:UndoStack = UndoStack(event.target);
            Assert.assertStrictlyEquals(UndoEvent.REDO, event.type);
            Assert.assertStrictlyEquals(1, undo.undoCount);
            Assert.assertStrictlyEquals(0, undo.redoCount);
        }
        
        private function onPushUndo(event:UndoEvent, ignore:Object):void
        {
            var undo:UndoStack = UndoStack(event.target);
            Assert.assertStrictlyEquals(UndoEvent.PUSH, event.type);
            Assert.assertStrictlyEquals(1, undo.undoCount);
            Assert.assertStrictlyEquals(0, undo.redoCount);
        }
    }
}