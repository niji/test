package com.github.niji.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;
    import com.github.niji.framework.commands.CompositeCommand;
    import com.github.niji.framework.commands.UndoCommand;
    import com.github.niji.framework.errors.UndoError;
    import com.github.niji.framework.events.CommandEvent;
    import com.github.niji.framework.events.PlayerErrorEvent;
    import com.github.niji.framework.events.PlayerEvent;
    import com.github.niji.framework.Player;

    public class PlayerTest
    {
        [Test(desription="プレイヤーが再生されるとplayingがtrueになること")]
        public function shouldPlayingBeTrueIfPlayed():void
        {
            var player:Player = newPlayer();
            player.start();
            Assert.assertTrue(player.playing);
            player.stop();
        }
        
        [Test(async, desription="プレイヤーが再生されるとPlayerEvent.STARTEDが呼ばれること")]
        public function shouldDispatchStartEventAfterPlay():void
        {
            var player:Player = newPlayer();
            player.addEventListener(PlayerEvent.STARTED,
                Async.asyncHandler(this, onPlayerStarted, 100));
            player.start();
            player.stop();
        }
        
        [Test(description="プレイヤーが停止されるとplayingがfalseになること")]
        public function shouldPlayingBeFalseIfStopped():void
        {
            var player:Player = newPlayer();
            player.start();
            player.stop();
            Assert.assertFalse(player.playing);
        }
        
        [Test(async, desription="プレイヤーが停止されるとPlayerEvent.STOPPEDが呼ばれること")]
        public function shouldDispatchStopEventAfterStop():void
        {
            var player:Player = newPlayer();
            player.addEventListener(PlayerEvent.STOPPED,
                Async.asyncHandler(this, onPlayerStopped, 100));
            player.start();
            player.stop();
        }
        
        [Test(async, desription="プレイヤーが一時停止されるとPlayerEvent.PAUSEDが呼ばれること")]
        public function shouldDispatchPauseEventAfterPause():void
        {
            var player:Player = newPlayer();
            player.addEventListener(PlayerEvent.PAUSED,
                Async.asyncHandler(this, onPlayerPaused, 100));
            player.start();
            player.pause();
        }
        
		[Test(description="正しい署名が入っていないログを読み込むと例外を送出すること",
              expects="com.github.niji.framework.errors.InvalidSignatureError")]
        public function shouldThrowInvalidSignatureErrorIfLogInvalid():void
        {
            var bytes:ByteArray = new ByteArray();
            // 14bytes は最低でも埋める
            bytes.writeUTFBytes("12345678901234");
            bytes.position = 0;
            Player.create(bytes);
        }
        
        [Test(description="サポートしないバージョンのログを読み込むと例外を送出する",
              expects="com.github.niji.framework.errors.NotSupportedVersionError")]
        public function shouldThrowNotSupportedVersionErrorIfNotSupportedVersionSeen():void
        {
            var bytes:ByteArray = newPlayerLog("0.0.0");
            Player.create(bytes);
        }
        
        [Test(description="バージョン0_1_0まではPaintEngineV1が使われること")]
        public function shouldUsePaintEngineV1():void
        {
            var bytes:ByteArray = newPlayerLog("0.1.0");
            var player:Player = Player.create(bytes);
            Assert.assertEquals(10, player.version);
            // internal 参照なので、 オブジェクトを文字列化して比較する
            // Assert.assertEquals("[object PainterV1]", painter. + "");
        }
        
        [Test(description="バージョン0_2_0以降はPaintEngineV2が使われること")]
        public function shouldUsePaintEngineV2():void
        {
            var bytes:ByteArray = newPlayerLog("0.2.0");
            var player:Player = Player.create(bytes);
            Assert.assertEquals(20, player.version);
            // internal 参照なので、 オブジェクトを文字列化して比較する
            // Assert.assertEquals("[object PainterV2]", painter.painter + "");
        }
        
        [Test(async, description="コマンドが解析されるとCommandEvent.PARSEDが呼ばれること")]
        public function shouldDispatchParseEventAfterPlay():void
        {
            var player:Player = Player.create(newPlayerLogWithComposite());
            player.addEventListener(CommandEvent.PARSE,
                Async.asyncHandler(this, onCommandParsed, 500));
            player.start();
        }
        
        [Test(async, description="コマンドが実行されるとPlayerEvent.UPDATEDが呼ばれること")]
        public function shouldDispatchUpdateEventAfterPlay():void
        {
            var player:Player = Player.create(newPlayerLogWithComposite());
            player.addEventListener(PlayerEvent.UPDATED,
                Async.asyncHandler(this, onPlayerUpdated, 500));
            player.start();
        }
        
        [Test(async, description="再生が完了するとPlayerEvent.FINISHEDが呼ばれること")]
        public function shouldDispatchFinishEventAfterPlayFinished():void
        {
            var player:Player = Player.create(newPlayerLogWithComposite());
            player.addEventListener(PlayerEvent.FINISHED,
                Async.asyncHandler(this, onPlayerFinished, 1000));
            player.start();
        }
        
        [Test(async, description="再生エラーが発生するとPlayerErrorEvent.ERRORが呼ばれること")]
        public function shouldDispatchErrorEventWithPlayError():void
        {
            var bytes:ByteArray = newPlayerLog("0.1.0");
            // ログ位置が0に設定されてしまうので最後尾に戻す
            bytes.position = bytes.bytesAvailable;
            bytes.writeByte(UndoCommand.ID);
            var player:Player = Player.create(bytes);
            // 本来は false だが巻き戻しで意図的に例外を起こすために true にしておく
            player.undoStack.throwsError = true;
            player.addEventListener(PlayerErrorEvent.ERROR,
                Async.asyncHandler(this, onPlayerError, 500));
            player.start();
        }
        
        private function newPlayerLogWithComposite():ByteArray
        {
            var bytes:ByteArray = newPlayerLog("0.1.0");
            // ログ位置が0に設定されてしまうので最後尾に戻す
            bytes.position = bytes.bytesAvailable;
            bytes.writeByte(CompositeCommand.ID);
            return bytes;
        }
        
        private function newPlayerLog(version:String):ByteArray
        {
            var bytes:ByteArray = new ByteArray();
            // シグネチャ
            bytes.writeUTFBytes("GUNYARA_PAINT:");
            // バージョン番号
            bytes.writeUTFBytes(version + ":");
            // 画像の幅
            bytes.writeShort(123);
            // 画像の高さ
            bytes.writeShort(321);
            // 最大巻き戻し回数
            bytes.writeShort(16);
            // 読み込みする必要があるので最初の位置に戻す
            bytes.position = 0;
            return bytes;
        }
        
        private function newPlayer():Player
        {
            var bytes:ByteArray = new ByteArray();
            bytes.writeUTFBytes("GUNYARA_PAINT:0.1.0:");
            bytes.writeShort(1);
            bytes.writeShort(1);
            bytes.writeShort(1);
            bytes.position = 0;
            var player:Player = Player.create(bytes);
            player.duration = 10000;
            return player;
        }
        
        private function onPlayerStarted(event:PlayerEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(PlayerEvent.STARTED, event.type);
        }
        
        private function onPlayerStopped(event:PlayerEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(PlayerEvent.STOPPED, event.type);
        }
        
        private function onPlayerPaused(event:PlayerEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(PlayerEvent.PAUSED, event.type);
        }
        
        private function onPlayerUpdated(event:PlayerEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(PlayerEvent.UPDATED, event.type);
        }
        
        private function onPlayerFinished(event:PlayerEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(PlayerEvent.FINISHED, event.type);
            Assert.assertFalse(Player(event.target).playing);
        }
        
        private function onPlayerError(event:PlayerErrorEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(PlayerErrorEvent.ERROR, event.type);
            Assert.assertTrue(event.cause is UndoError);
        }
        
        private function onCommandParsed(event:CommandEvent, ignore:Object):void
        {
            Assert.assertStrictlyEquals(CommandEvent.PARSE, event.type);
            Assert.assertTrue(event.command is CompositeCommand);
        }
    }
}