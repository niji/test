package org.libspark.gunyarapaint.framework
{
    import flash.display.BitmapData;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.LayerBitmapCollection;

    public class LayerBitmapContainerTest
    {
        public const WIDTH:int = 123;
        public const HEIGHT:int = 321;
        
        [Test(description="画像の大きさを指定するとLayerCollectionが作成されること")]
        public function should_create_LayerCollection():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            Assert.assertStrictlyEquals(1, lc.count);
            Assert.assertStrictlyEquals(WIDTH, lc.width);
            Assert.assertStrictlyEquals(HEIGHT, lc.height);
            Assert.assertStrictlyEquals(WIDTH, lc.currentLayer.width);
            Assert.assertStrictlyEquals(HEIGHT, lc.currentLayer.height);
        }
        
        [Test(description="レイヤーが追加されること")]
        public function should_add_layer():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.add();
            Assert.assertStrictlyEquals(2, lc.count);
            Assert.assertStrictlyEquals("Layer1", lc.currentLayer.name);
        }
        
        [Test(description="レイヤーのコピーが作成されること")]
        public function should_copy_layer():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.copy();
            Assert.assertStrictlyEquals(2, lc.count);
            Assert.assertStrictlyEquals("Background's copy", lc.currentLayer.name);
        }
        
        [Test(description="レイヤーの交換が行われること")]
        public function should_swap_layers():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.add();
            lc.at(0).name = "foo";
            lc.at(1).name = "bar";
            lc.swap(0, 1);
            Assert.assertStrictlyEquals("bar", lc.at(0).name);
            Assert.assertStrictlyEquals("foo", lc.at(1).name);
        }
        
        [Test(description="レイヤーが統合されて、統合後のAlpha値が1.0になること")]
        public function should_merge_layers():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.add();
            lc.at(0).alpha = 0.5;
            lc.merge();
            Assert.assertStrictlyEquals(1, lc.count);
            Assert.assertStrictlyEquals(1.0, lc.at(0).alpha);
        }
        
        [Test(description="両方のレイヤーが可視でなければ統合が失敗すること",
              expects="org.libspark.gunyarapaint.framework.errors.MergeLayersError")]
        public function should_throw_MergeLayersError_if_invisible_layer_found():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.add();
            lc.at(0).visible = false;
            lc.at(1).visible = false;
            lc.merge();
        }
        
        [Test(description="レイヤーがひとつしか無ければ失敗すること",
              expects="org.libspark.gunyarapaint.framework.errors.MergeLayersError")]
        public function should_throw_MergeLayersError_if_only_one_layer_found():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.merge();
        }
        
        [Test(description="規定数以上のレイヤーを作成すると例外を送出すること",
              expects="org.libspark.gunyarapaint.framework.errors.AddLayerError")]
        public function should_throw_AddLayerError_if_create_layer_over_max():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            var max:uint = LayerBitmapCollection.MAX;
            for (var i:uint = 0; i < max; i++) {
                lc.add();
            }
        }
        
        [Test(description="規定数以上のレイヤーをコピーすると例外を送出すること",
              expects="org.libspark.gunyarapaint.framework.errors.AddLayerError")]
        public function should_throw_AddLayerError_if_copy_layer_over_max():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            var max:uint = LayerBitmapCollection.MAX ;
            for (var i:uint = 0; i < max; i++) {
                lc.copy();
            }
        }
        
        [Test(description="レイヤーが削除されること")]
        public function should_remove_layer():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.add();
            lc.remove();
            Assert.assertStrictlyEquals(1, lc.count);
        }
        
        [Test(description="レイヤーが1枚しか無い状態で削除すると例外を送出すること",
              expects="org.libspark.gunyarapaint.framework.errors.RemoveLayerError")]
        public function should_throw_RemoveLayerErro_if_remove_bottom_layer():void
        {
            var lc:LayerBitmapCollection = newLayerBitmapCollection();
            lc.remove();
        }
        
        [Test(description="投稿時にレイヤー画像が一定のピクセル数以上だと例外を送出すること",
              expects="org.libspark.gunyarapaint.framework.errors.TooManyLayersError")]
        public function should_throw_TooManyLayersErorr_if_layer_have_many():void
        {
            var lc:LayerBitmapCollection = new LayerBitmapCollection(12, 34);
            var bitmap:BitmapData = new BitmapData(lc.width, LayerBitmapCollection.MAX_PIXEL + 1);
            var metadata:Object = {};
            lc.save(bitmap, metadata);
        }
        
        private function newLayerBitmapCollection():LayerBitmapCollection
        {
            return new LayerBitmapCollection(WIDTH, HEIGHT);
        }
    }
}