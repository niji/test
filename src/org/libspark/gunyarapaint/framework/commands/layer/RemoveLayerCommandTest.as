package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.RemoveLayerCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakeLayerBitmapCollection;

    public class RemoveLayerCommandTest
    {
        [Test]
        public function レイヤー削除コマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new RemoveLayerCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            bytes.position = 0;
            Assert.assertEquals(RemoveLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakeLayerBitmapCollection.didRemoveLayer);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}