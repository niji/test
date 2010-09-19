package com.github.niji.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakeLayerList;
    import com.github.niji.framework.commands.layer.MergeLayerCommand;

    public class MergeLayerCommandTest
    {
        [Test(description="レイヤー統合コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new MergeLayerCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[MergeLayerCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(MergeLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakeLayerList.didMergeLayer);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
