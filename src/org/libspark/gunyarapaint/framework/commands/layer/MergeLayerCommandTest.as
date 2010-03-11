package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.MergeLayerCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakeLayerBitmapCollection;

    public class MergeLayerCommandTest
    {
        [Test]
        public function レイヤー統合コマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new MergeLayerCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            bytes.position = 0;
            Assert.assertEquals(MergeLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakeLayerBitmapCollection.didMergeLayer);
            Assert.assertTrue(painter.didPushUndoIfNeed);
        }
    }
}