package org.libspark.gunyarapaint.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Player;

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
        
        [Test(description="プレイヤーが停止されるとplayingがfalseになること")]
        public function shouldPlayingBeFalseIfStopped():void
        {
            var player:Player = newPlayer();
            player.start();
            player.stop();
            Assert.assertFalse(player.playing);
        }
		
		[Test(description="正しい署名が入っていないログを読み込むと例外を送出すること",
              expects="org.libspark.gunyarapaint.framework.errors.InvalidSignatureError")]
        public function shouldThrowInvalidSignatureErrorIfLogInvalid():void
        {
            var bytes:ByteArray = new ByteArray();
            // 14bytes は最低でも埋める
            bytes.writeUTFBytes("12345678901234");
            bytes.position = 0;
            Player.create(bytes);
        }
        
        [Test(description="サポートしないバージョンのログを読み込むと例外を送出する",
              expects="org.libspark.gunyarapaint.framework.errors.NotSupportedVersionError")]
        public function shouldThrowNotSupportedVersionErrorIfNotSupportedVersionSeen():void
        {
            var bytes:ByteArray = newPlayerLog("0.0.0");
            Player.create(bytes);
        }
        
        [Test(description="バージョン0_1_0まではPaintEngineV1が使われること")]
        public function shouldUsePaintEngineV1():void
        {
            var bytes:ByteArray = newPlayerLog("0.1.0");
            var painter:Player = Player.create(bytes);
            Assert.assertEquals(10, painter.version);
            // internal 参照なので、 オブジェクトを文字列化して比較する
            // Assert.assertEquals("[object PainterV1]", painter. + "");
        }
        
        [Test(description="バージョン0_2_0以降はPaintEngineV2が使われること")]
        public function shouldUsePaintEngineV2():void
        {
            var bytes:ByteArray = newPlayerLog("0.2.0");
            var painter:Player = Player.create(bytes);
            Assert.assertEquals(20, painter.version);
            // internal 参照なので、 オブジェクトを文字列化して比較する
            // Assert.assertEquals("[object PainterV2]", painter.painter + "");
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
    }
}