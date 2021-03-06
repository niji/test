package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class HorizontalMirrorCommandTest
    {
        [Test(description="水平ミラー作成コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new HorizontalMirrorCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "index": 42 };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[HorizontalMirrorCommand index=42]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(HorizontalMirrorCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.index, painter.layerIndex);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
