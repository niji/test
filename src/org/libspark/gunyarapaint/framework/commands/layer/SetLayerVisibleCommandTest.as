package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerVisibleCommand;
    import org.libspark.gunyarapaint.framework.FakeCanvasContext;
    import org.libspark.gunyarapaint.framework.FakeCanvasContext;

    public class SetLayerVisibleCommandTest
    {
        [Test]
        public function レイヤーのインデックスを設定するコマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SetLayerVisibleCommand();
            var canvas:FakeCanvasContext = new FakeCanvasContext();
            var args:Object = { "index": 0, "visible": false };
            command.write(bytes, args);
            bytes.position = 0;
            Assert.assertEquals(SetLayerVisibleCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(canvas);
            //Assert.assertEquals(args.visible, FakeCanvasContext.layerBitmap.visible);
            Assert.assertTrue(canvas.didPushUndoIfNeed);
        }
    }
}