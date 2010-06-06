package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerVisibleCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakePainter;

    public class SetLayerVisibleCommandTest
    {
        [Test(description="レイヤーのインデックスを設定するコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SetLayerVisibleCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "index": 0, "visible": false };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[SetLayerVisibleCommand index=0, visible=false]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(SetLayerVisibleCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.visible, FakePainter.layerVisible);
        }
    }
}
