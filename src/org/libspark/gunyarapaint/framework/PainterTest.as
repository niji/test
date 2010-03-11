package org.libspark.gunyarapaint.framework
{
    import flash.display.BlendMode;
    import flash.display.CapsStyle;
    import flash.display.DisplayObject;
    import flash.display.JointStyle;
    import flash.display.Shape;
    import flash.display.Sprite;
    
    import org.flexunit.Assert;

    public class PainterTest
    {
        [Test]
        public function ペンの設定():void
        {
            var pen:Pen = new Pen();
            pen.blendMode = BlendMode.ADD;
            pen.capsStyle = CapsStyle.SQUARE;
            pen.color = 0xffff00;
            pen.jointStyle = JointStyle.BEVEL;
            pen.miterLimit = 8;
            pen.pixelHinting = false;
            pen.thickness = 8;
            var cc:Painter = newPainter();
            cc.pen = pen;
            var fakedPen:Pen = FakePaintEngine.fakedPen;
            Assert.assertStrictlyEquals(fakedPen.blendMode, pen.blendMode);
            Assert.assertStrictlyEquals(fakedPen.capsStyle, pen.capsStyle);
            Assert.assertStrictlyEquals(fakedPen.color, pen.color);
            Assert.assertStrictlyEquals(fakedPen.jointStyle, pen.jointStyle);
            Assert.assertStrictlyEquals(fakedPen.miterLimit, pen.miterLimit);
            Assert.assertStrictlyEquals(fakedPen.pixelHinting, pen.pixelHinting);
            Assert.assertStrictlyEquals(fakedPen.thickness, pen.thickness);
        }
        
        [Test]
        public function 座標の移動():void
        {
            var x:int = 42;
            var y:int = 124;
            var cc:Painter = newPainter();
            cc.moveTo(x, y);
            Assert.assertStrictlyEquals(x, FakePaintEngine.point.x);
            Assert.assertStrictlyEquals(y, FakePaintEngine.point.y);
        }
        
        [Test]
        public function 円の描写():void
        {
            var radius:Number = 3.14;
            var cc:Painter = newPainter();
            cc.drawCircle(radius);
            Assert.assertStrictlyEquals(radius, FakePaintEngine.radius);
        }
        
        [Test]
        public function 長方形の描写():void
        {
            var x:int = 42;
            var y:int = 124;
            var width:int = 256;
            var height:int = 512;
            var cc:Painter = newPainter();
            cc.drawRect(x, y, width, height);
            Assert.assertStrictlyEquals(x, FakePaintEngine.rectangle.x);
            Assert.assertStrictlyEquals(y, FakePaintEngine.rectangle.y);
            Assert.assertStrictlyEquals(width, FakePaintEngine.rectangle.width);
            Assert.assertStrictlyEquals(height, FakePaintEngine.rectangle.height);
        }
        
        [Test]
        public function 楕円の描写():void
        {
            var x:int = 512;
            var y:int = 256;
            var width:int = 128;
            var height:int = 64;
            var cc:Painter = newPainter();
            cc.drawEllipse(x, y, width, height);
            Assert.assertStrictlyEquals(x, FakePaintEngine.rectangle.x);
            Assert.assertStrictlyEquals(y, FakePaintEngine.rectangle.y);
            Assert.assertStrictlyEquals(width, FakePaintEngine.rectangle.width);
            Assert.assertStrictlyEquals(height, FakePaintEngine.rectangle.height);
        }
        
        [Test]
        public function 塗りつぶし():void
        {
            var color:uint = uint.MAX_VALUE;
            var alpha:Number = 0.5;
            var cc:Painter = newPainter();
            cc.beginFill(color, alpha);
            cc.endFill();
            Assert.assertStrictlyEquals(color, FakePaintEngine.color);
            Assert.assertStrictlyEquals(alpha, FakePaintEngine.alpha);
            Assert.assertTrue(FakePaintEngine.filled);
        }
        
        [Test]
        public function 描写レイヤーの追加と削除():void
        {
            var child:DisplayObject;
            var cc:Painter = newPainter();
            // 描写セッションの開始されると一時 Sprite が作成される
            // その為、上に現在のレイヤーが、下に描写バッファが入る
            cc.startDrawingSession();
            child = cc.view.getChildAt(0);
            Assert.assertTrue(child is Sprite);
            var sprite:Sprite = Sprite(child);
            Assert.assertTrue(sprite.getChildAt(0) is LayerBitmap);
            Assert.assertTrue(sprite.getChildAt(1) is Shape);
            // 描写セッションが終了すると一時 Sprite が削除され、現在のレイヤーに戻される
            cc.stopDrawingSession();
            child = cc.view.getChildAt(0);
            Assert.assertTrue(child is LayerBitmap);
        }
        
        private function newPainter():Painter
        {
            return new Painter(1, 1, Painter.PAINTER_LOG_VERSION, new FakePaintEngine());
        }
    }
}