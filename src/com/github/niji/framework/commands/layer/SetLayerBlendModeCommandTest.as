package com.github.niji.framework.commands.layer
{
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.ICommand;
    
    import flash.display.BlendMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class SetLayerBlendModeCommandTest
    {
        [Test(description="レイヤーのブレンドモードを設定するコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SetLayerBlendModeCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "blendMode": BlendMode.ADD };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[SetLayerBlendModeCommand blendMode=" + BlendMode.ADD + "]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(SetLayerBlendModeCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.blendMode, painter.layerBlendMode);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
