package org.libspark.gunyarapaint.framework
{
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
        
        [Test]
        public function レイヤー情報の保存と復帰():void
        {
            var metadata:Object = {};
            var cc:Painter = newPainter();
            var layers:BitmapData = new BitmapData(cc.width, cc.height * 3);
            cc.layers.add();
            cc.layers.add();
            var src:LayerBitmap = cc.layers.at(2);
            src.alpha = 0.5;
            src.blendMode = BlendMode.ADD;
            src.locked = true;
            src.name = "test012";
            src.visible = false;
            cc.save(layers, metadata);
            Assert.assertEquals(cc.width, metadata.width);
            Assert.assertEquals(cc.height, metadata.height);
            Assert.assertEquals(3, metadata.layer_infos.length);
            var cc2:Painter = newPainter();
            cc2.load(layers, metadata);
            Assert.assertEquals(3, cc2.layers.count);
            var dst:LayerBitmap = cc2.layers.at(2);
            Assert.assertEquals(src.alpha, dst.alpha);
            Assert.assertEquals(src.blendMode, dst.blendMode);
            Assert.assertTrue(dst.locked);
            Assert.assertEquals(src.name, dst.name);
            Assert.assertFalse(dst.visible);
        }
        
        private function newPainter():Painter
        {
            return new Painter(1, 1, Painter.PAINTER_LOG_VERSION, new FakePaintEngine());
        }
    }
}