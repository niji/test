package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.display.BlendMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerBlendModeCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakePainter;

    public class SetLayerBlendModeCommandTest
    {
        [Test]
        public function レイヤーのブレンドモードを設定するコマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SetLayerBlendModeCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "blendMode": BlendMode.ADD };
            command.write(bytes, args);
            bytes.position = 0;
            Assert.assertEquals(SetLayerBlendModeCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.blendMode, FakePainter.layerBlendMode);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}