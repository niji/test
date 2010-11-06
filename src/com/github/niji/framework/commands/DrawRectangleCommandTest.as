package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class DrawRectangleCommandTest
    {
        [Test(description="矩形を描写するコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new DrawRectangleCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = {
                "width": 123,
                "height": -321
            };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[DrawRectangleCommand width=123 height=-321]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(DrawRectangleCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            var rect:Rectangle = painter.fakePaintEngine.rectangle;
            Assert.assertEquals(args.width, rect.width);
            Assert.assertEquals(args.height, rect.height);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
