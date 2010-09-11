package com.github.niji.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.commands.LineToCommand;
    import com.github.niji.framework.commands.MoveToCommand;
    import com.github.niji.framework.commands.RedoCommand;
    import com.github.niji.framework.commands.UndoCommand;
    import com.github.niji.framework.commands.layer.CopyLayerCommand;
    import com.github.niji.framework.events.CommandEvent;
    import com.github.niji.framework.Parser;

    public class ParserTest
    {
        [Test(description="ログデータが26bytes未満の場合例外を送出すること", expects="ArgumentError")]
        public function shouldThrowArgumentErrorIfLengthIsLessThan26bytes():void
        {
            var parser:Parser = new Parser(new ByteArray());
            parser.rewind();
        }
        
        [Test(description="ログデータをヘッダーを読み込んだ後の位置に変更すること")]
        public function shouldBeAtHeadOfBody():void
        {
            var parser:Parser = new Parser(newBytesWithDummyHeader());
            parser.rewind();
            Assert.assertEquals(Parser.EOH, parser.bytes.position);
        }
        
        [Test(async, description="対象のログデータが先読みでコマンドが7個で、最大巻き戻し回数が4回であることを確認すること")]
        public function shouldTargetIs4UndoCountAnd7CommandCount():void
        {
            var bytes:ByteArray = newBytesWithDummyHeader();
            // 連続して巻き戻し及びやり直しが発生するのは4回
            bytes.writeByte(UndoCommand.ID);
            bytes.writeByte(RedoCommand.ID);
            bytes.writeByte(RedoCommand.ID);
            bytes.writeByte(UndoCommand.ID);
            // ここでリセットされる。次も連続して2回行われるが先ほどの4回を上回らないため更新されない
            bytes.writeByte(CopyLayerCommand.ID);
            bytes.writeByte(RedoCommand.ID);
            bytes.writeByte(UndoCommand.ID);
            var parser:Parser = new Parser(bytes);
            parser.addEventListener(CommandEvent.PREPARSE,
                Async.asyncHandler(this, onPreparse, 100));
            parser.preparse();
            Assert.assertEquals(4, parser.maxUndoCount);
            Assert.assertEquals(7, parser.count);
        }
        
        [Test(async, description="コマンドが登録されるとCommandEvent.REGISTEREDが呼ばれること")]
        public function shouldDispatchRegisterEventAfterRegistered():void
        {
            var parser:Parser = new Parser(new ByteArray());
            parser.addEventListener(CommandEvent.REGISTERED,
                Async.asyncHandler(this, onRegistered, 100));
            parser.registerCommand(new FakeCommand());
        }
        
        [Test(async, description="コマンドが解除されるとCommandEvent.UNREGISTEREDが呼ばれること")]
        public function shouldDispatchUnregisterEventAfterUnregistered():void
        {
            var parser:Parser = new Parser(new ByteArray());
            var command:ICommand = new FakeCommand();
            parser.addEventListener(CommandEvent.UNREGISTERED,
                Async.asyncHandler(this, onUnregistered, 100));
            parser.registerCommand(command);
            parser.unregisterCommand(command);
        }
        
        private function onPreparse(event:CommandEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(CommandEvent.PREPARSE, event.type);
        }
        
        private function onRegistered(event:CommandEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(CommandEvent.REGISTERED, event.type);
            Assert.assertTrue(event.command is FakeCommand);
        }
        
        private function onUnregistered(event:CommandEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(CommandEvent.UNREGISTERED, event.type);
            Assert.assertTrue(event.command is FakeCommand);
        }
        
        private function newBytesWithDummyHeader():ByteArray
        {
            var bytes:ByteArray = new ByteArray();
            // シグネチャ
            bytes.writeUTFBytes("GUNYARA_PAINT:");
            // バージョン番号
            bytes.writeUTFBytes("0.1.0:");
            // 画像の幅
            bytes.writeShort(123);
            // 画像の高さ
            bytes.writeShort(321);
            // 最大巻き戻し回数
            bytes.writeShort(16);
            return bytes;
        }
        
        private function dispatchCommand(method:String, command:ICommand):void
        {
            var parser:Parser = new Parser(new ByteArray());
            parser[method](command);
        }
    }
}