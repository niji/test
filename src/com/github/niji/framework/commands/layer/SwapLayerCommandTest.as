package com.github.niji.framework.commands.layer
{
    import com.github.niji.framework.FakeLayerList;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.ICommand;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

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
            var layers:FakeLayerList = FakeLayerList(painter.layers);
            Assert.assertEquals(args.from, layers.didSwapLayerFrom);
            Assert.assertEquals(args.to, layers.didSwapLayerTo);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
