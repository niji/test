package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerAlphaCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakePainter;

    public class SetLayerAlphaCommandTest
    {
        [Test]
        public function レイヤーの透明度を設定するコマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SetLayerAlphaCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "alpha": 0.314 };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[SetLayerAlphaCommand alpha=0.3140]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(SetLayerAlphaCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.alpha, FakePainter.layerAlpha);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
