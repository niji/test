package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.Painter;

    public class CompatibilityCommandTest
    {
        [Test]
        public function 互換性オプションのうちレイヤーのアンドゥを有効にする設定の実行():void
        {
            // default is false
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new CompatibilityCommand();
            var painter:FakePainter = new FakePainter();
            Assert.assertFalse(painter.enableUndoLayer);
            command.write(bytes, {
                "type": Painter.COMPATIBILITY_UNDO_LAYER,
                "value": true
            });
            bytes.position = 0;
            Assert.assertEquals(CompatibilityCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(painter.enableUndoLayer);
        }
        
        [Test]
        public function 互換性オプションのうち大きなピクセルを無効にする設定の実行():void
        {
            // default is true
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new CompatibilityCommand();
            var painter:FakePainter = new FakePainter();
            Assert.assertTrue(painter.enableBigPixel);
            command.write(bytes, {
                "type": Painter.COMPATIBILITY_BIG_PIXEL,
                "value": false
            });
            bytes.position = 0;
            Assert.assertEquals(CompatibilityCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertFalse(painter.enableBigPixel);
        }
    }
}