package com.github.niji.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.layer.SetLayerAlphaCommand;

    public class SetLayerAlphaCommandTest
    {
        [Test(description="レイヤーの透明度を設定するコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
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
