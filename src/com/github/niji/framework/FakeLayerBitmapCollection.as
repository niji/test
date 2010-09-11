package com.github.niji.framework
{
    import flash.display.BitmapData;
    
    import org.libspark.gunyarapaint.framework.BitmapLayer;
    import org.libspark.gunyarapaint.framework.ILayer;
    import org.libspark.gunyarapaint.framework.LayerCollection;
    
	/**
	 * LayerBitmapCollection を継承したスタブクラス。実行したかのフラグ管理を行う。
	 * 
	 * レイヤー関連のコマンドのテストで使う。本当は継承ではなく、インターフェースの実装とするべきではあるが、
	 * 再設計が必要になってしまうので継承とした。
	 */	
    public class FakeLayerBitmapCollection extends LayerCollection
    {
        public function FakeLayerBitmapCollection(width:int, height:int)
        {
            super(width, height);
            didAddLayer = false;
            didCopyLayer = false;
            didSwapLayerFrom = 0;
            didSwapLayerTo = 0;
            didMergeLayer = false;
            didRemoveLayer = false;
            layerBitmap = new BitmapLayer(new BitmapData(1, 1));
        }
        
        public override function add():void
        {
            didAddLayer = true;
        }
        
        public override function copy():void
        {
            didCopyLayer = true;
        }
        
        public override function swap(from:int, to:int):void
        {
            didSwapLayerFrom = from;
            didSwapLayerTo = to;
        }
        
        public override function merge():void
        {
            didMergeLayer = true;
        }
        
        public override function remove():void
        {
            didRemoveLayer = true;
        }
        
        public override function get currentLayer():ILayer
        {
            return layerBitmap;
        }
        
        public static var didAddLayer:Boolean;
        public static var didCopyLayer:Boolean;
        public static var didSwapLayerFrom:uint;
        public static var didSwapLayerTo:uint;
        public static var didMergeLayer:Boolean;
        public static var didRemoveLayer:Boolean;
        public static var layerBitmap:BitmapLayer;
    }
}