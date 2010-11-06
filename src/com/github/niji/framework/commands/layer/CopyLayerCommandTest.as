package com.github.niji.framework.commands.layer
{
    import com.github.niji.framework.FakeLayerList;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.ICommand;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class CopyLayerCommandTest
    {
        [Test(description="レイヤーコピーコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new CopyLayerCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[CopyLayerCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(CopyLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakeLayerList(painter.layers).didCopyLayer);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
