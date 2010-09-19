package com.github.niji.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakeLayerList;
    import com.github.niji.framework.commands.layer.RemoveLayerCommand;

    public class RemoveLayerCommandTest
    {
        [Test(description="レイヤー削除コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new RemoveLayerCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[RemoveLayerCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(RemoveLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakeLayerList.didRemoveLayer);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
