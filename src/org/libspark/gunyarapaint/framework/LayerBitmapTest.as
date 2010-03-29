package org.libspark.gunyarapaint.framework
{
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.LayerBitmap;

    // LayerBitmap#compositeTo is tested in PainterTest#レイヤー情報の保存と復帰
    public class LayerBitmapTest
    {
        [Test]
        public function レイヤーの作成():void
        {
            var layer:LayerBitmap = new LayerBitmap(smallBitmapData);
            Assert.assertTrue(layer is LayerBitmap);
        }
        
        [Test]
        public function レイヤーのクローン():void
        {
            var layer:LayerBitmap = layerToClone;
            var newLayer:LayerBitmap = layer.clone();
            assertLayerMetadata(layer, newLayer);
            Assert.assertStrictlyEquals(layer.index, newLayer.index);
            // LayerBitmap#bitmapData is the internal method
            Assert.assertEquals(0, newLayer.bitmapData.compare(layer.bitmapData));
        }
        
        [Test]
        public function 塗りつぶし():void
        {
            var bmd:BitmapData = bigBitmapData;
            var layer:LayerBitmap = new LayerBitmap(bmd);
            layer.floodFill(5, 5, 0);
            Assert.assertStrictlyEquals(0, layer.bitmapData.getPixel32(5, 5));
            Assert.assertStrictlyEquals(0, layer.bitmapData.getPixel32(0, 0));
        }
        
        [Test]
        public function ドットうち():void
        {
            var bmd:BitmapData = bigBitmapData;
            var layer:LayerBitmap = new LayerBitmap(bmd);
            layer.setPixel(5, 5, 0);
            Assert.assertStrictlyEquals(0, layer.bitmapData.getPixel32(5, 5));
            Assert.assertStrictlyEquals(uint.MAX_VALUE, layer.bitmapData.getPixel32(0, 0));
        }
        
        [Test]
        public function レイヤーのJSONシリアライズ():void
        {
            var layer:LayerBitmap = layerToClone;
            var newLayer:LayerBitmap = new LayerBitmap(bigBitmapData);
            newLayer.fromJSON(layer.toJSON());
            assertLayerMetadata(layer, newLayer);
            Assert.assertStrictlyEquals(layer.locked, newLayer.locked);
        }
        
        private function assertLayerMetadata(layer:LayerBitmap, newLayer:LayerBitmap):void
        {
            Assert.assertStrictlyEquals(layer.alpha, newLayer.alpha);
            Assert.assertStrictlyEquals(layer.blendMode, newLayer.blendMode);
            Assert.assertStrictlyEquals(layer.name, newLayer.name);
            Assert.assertStrictlyEquals(layer.visible, newLayer.visible);
        }
        
        private function get layerToClone():LayerBitmap
        {
            var layer:LayerBitmap = new LayerBitmap(bigBitmapData);
            layer.alpha = 0.42;
            layer.blendMode = BlendMode.MULTIPLY;
            layer.index = 42;
            layer.locked = true;
            layer.name = "test";
            layer.visible = false;
            return layer;
        }
        
        private function get smallBitmapData():BitmapData
        {
            return new BitmapData(1, 1);
        }
        
        private function get bigBitmapData():BitmapData
        {
            return new BitmapData(10, 10);
        }
    }
}