package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.Painter;

    public class CompatibilityCommandTest
    {
        [Test(description="互換性オプションのうちレイヤーのアンドゥを有効にする設定が正しく実行されること")]
        public function shouldExecuteUndoLayerCompatibilityCorrectly():void
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
            Assert.assertStrictlyEquals(
                "[CompatibilityCommand undoLayer=true]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(CompatibilityCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(painter.enableUndoLayer);
        }
        
        [Test(description="互換性オプションのうち大きなピクセルを無効にする設定が正しく実行されること")]
        public function shouldExecuteBigPixelCompatibilityCorrectly():void
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
            Assert.assertStrictlyEquals(
                "[CompatibilityCommand bigPixel=false]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(CompatibilityCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertFalse(painter.enableBigPixel);
        }
    }
}
