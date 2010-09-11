package com.github.niji.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakeLayerBitmapCollection;
    import com.github.niji.framework.commands.layer.SwapLayerCommand;

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
