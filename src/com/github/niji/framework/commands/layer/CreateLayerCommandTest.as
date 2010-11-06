package com.github.niji.framework.commands.layer
{
    import com.github.niji.framework.FakeLayerList;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.ICommand;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class CreateLayerCommandTest
    {
        [Test(description="レイヤー作成コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new CreateLayerCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[CreateLayerCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(CreateLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakeLayerList(painter.layers).didAddLayer);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
