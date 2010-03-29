package org.libspark.gunyarapaint.framework
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    
    import org.flexunit.Assert;

    public class PainterTest
    {
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
            child = cc.layers.view.getChildAt(0);
            Assert.assertTrue(child is Sprite);
            var sprite:Sprite = Sprite(child);
            Assert.assertTrue(sprite.getChildAt(0) is Bitmap);
            Assert.assertTrue(sprite.getChildAt(1) is Shape);
            // 描写セッションが終了すると一時 Sprite が削除され、現在のレイヤーに戻される
            cc.stopDrawingSession();
            child = cc.layers.view.getChildAt(0);
            Assert.assertTrue(child is Bitmap);
        }
        
        [Test]
        public function レイヤー情報の保存と復帰():void
        {
            var metadata:Object = {};
            var painter:Painter = newPainterForSave();
            var src:LayerBitmap = painter.layers.at(2);
            var layers:BitmapData = painter.newLayerBitmapData;
            painter.save(layers, metadata);
            Assert.assertEquals(metadata.width, painter.width);
            Assert.assertEquals(metadata.height, painter.height);
            Assert.assertEquals(3, metadata.layer_infos.length);
            var painter2:Painter = new Painter(3, 1, Painter.PAINTER_LOG_VERSION, new FakePaintEngine());
            painter2.load(layers, metadata);
            Assert.assertEquals(3, painter2.layers.count);
            var dst:LayerBitmap = painter2.layers.at(2);
            Assert.assertEquals(dst.alpha, src.alpha);
            Assert.assertEquals(dst.blendMode, src.blendMode);
            Assert.assertTrue(dst.locked);
            Assert.assertEquals(dst.name, src.name);
            Assert.assertFalse(dst.visible);
            // LayerBitmapCollection#compositeAll is the internal method.
            painter2.layers.compositeAll();
            Assert.assertEquals(0xff0000, painter2.getPixel(0, 0));
            Assert.assertEquals(0x00ff00, painter2.getPixel(1, 0));
            // layer(test012) is NOT visible
            Assert.assertEquals(0xffffff, painter2.getPixel(2, 0));
            // reset alpha, blend mode and visibility
            dst.blendMode = BlendMode.NORMAL;
            dst.alpha = 1;
            dst.visible = true;
            painter2.layers.compositeAll();
            var i2:Vector.<uint> = painter2.layers.composited.getVector(painter2.layers.composited.rect);
            // layer(test012) is now visible
            Assert.assertEquals(0x0000ff, painter2.getPixel(2, 0));
        }
        
        private function newPainter():Painter
        {
            return new Painter(1, 1, Painter.PAINTER_LOG_VERSION, new FakePaintEngine());
        }
        
        private function newPainterForSave():Painter
        {
            var painter:Painter = new Painter(3, 1, Painter.PAINTER_LOG_VERSION, new FakePaintEngine());
            painter.pen.color = 0xff0000;
            painter.setPixel(0, 0);
            painter.layers.add();
            painter.pen.color = 0x00ff00;
            painter.setPixel(1, 0);
            painter.layers.add();
            painter.pen.color = 0x0000ff;
            painter.setPixel(2, 0);
            var src:LayerBitmap = painter.layers.at(2);
            src.alpha = 0.5;
            src.blendMode = BlendMode.ADD;
            src.locked = true;
            src.name = "test012";
            src.visible = false;
            return painter;
        }
    }
}