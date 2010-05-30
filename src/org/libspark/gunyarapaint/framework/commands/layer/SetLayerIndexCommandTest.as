package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerIndexCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakePainter;

    public class SetLayerIndexCommandTest
    {
        [Test(description="レイヤーのインデックスを設定するコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new SetLayerIndexCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "index": 42 };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[SetLayerIndexCommand index=42]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(SetLayerIndexCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.index, painter.layers.currentIndex);
            Assert.assertTrue(painter.didPushUndo);
        }
		
		[Test(description="互換設定が入っている場合アンドゥに含めないこと")]
		public function shouldNotIncludeUndoIfCompatibilityEnabled():void
		{
			var bytes:ByteArray = new ByteArray();
			var command:ICommand = new SetLayerIndexCommand();
			var painter:FakePainter = new FakePainter();
			var args:Object = { "index": 42 };
			command.write(bytes, args);
			bytes.position = 0;
			bytes.readByte();
			painter.enableUndoLayer = true;
			command.read(bytes);
			command.execute(painter);
			Assert.assertFalse(painter.didPushUndo);
		}
    }
}
