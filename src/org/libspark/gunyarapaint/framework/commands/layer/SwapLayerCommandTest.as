package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.SwapLayerCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakeLayerBitmapCollection;

    public class SwapLayerCommandTest
    {
        [Test(description="レイヤー交換コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SwapLayerCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "from": 42, "to": 24 };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[SwapLayerCommand from=42, to=24]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(SwapLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.from, FakeLayerBitmapCollection.didSwapLayerFrom);
            Assert.assertEquals(args.to, FakeLayerBitmapCollection.didSwapLayerTo);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
