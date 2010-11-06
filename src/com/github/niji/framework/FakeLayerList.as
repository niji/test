package com.github.niji.framework
{
    import flash.display.BitmapData;
    
	/**
	 * LayerBitmapCollection を継承したスタブクラス。実行したかのフラグ管理を行う。
	 * 
	 * レイヤー関連のコマンドのテストで使う。本当は継承ではなく、インターフェースの実装とするべきではあるが、
	 * 再設計が必要になってしまうので継承とした。
	 */	
    public class FakeLayerList extends LayerList
    {
        public function FakeLayerList(width:int, height:int)
        {
            super(width, height);
            m_didAddLayer = false;
            m_didCopyLayer = false;
            m_didSwapLayerFrom = 0;
            m_didSwapLayerTo = 0;
            m_didMergeLayer = false;
            m_didRemoveLayer = false;
            m_layerBitmap = new BitmapLayer(new BitmapData(1, 1));
        }
        
        public override function add():void
        {
            m_didAddLayer = true;
        }
        
        public override function copy():void
        {
            m_didCopyLayer = true;
        }
        
        public override function swap(from:int, to:int):void
        {
            m_didSwapLayerFrom = from;
            m_didSwapLayerTo = to;
        }
        
        public override function merge():void
        {
            m_didMergeLayer = true;
        }
        
        public override function remove():void
        {
            m_didRemoveLayer = true;
        }
        
        public override function get currentLayer():ILayer
        {
            return m_layerBitmap;
        }
        
        public function get didAddLayer():Boolean
        {
            return m_didAddLayer;
        }
        
        public function get didCopyLayer():Boolean
        {
            return m_didCopyLayer;
        }
        
        public function get didSwapLayerFrom():uint
        {
            return m_didSwapLayerFrom;
        }
        
        public function get didSwapLayerTo():uint
        {
            return m_didSwapLayerTo;
        }
        
        public function get didMergeLayer():Boolean
        {
            return m_didMergeLayer;
        }
        
        public function get didRemoveLayer():Boolean
        {
            return m_didRemoveLayer;
        }
        
        public function get layerBitmap():BitmapLayer
        {
            return m_layerBitmap;
        }
        
        private var m_didAddLayer:Boolean;
        private var m_didCopyLayer:Boolean;
        private var m_didSwapLayerFrom:uint;
        private var m_didSwapLayerTo:uint;
        private var m_didMergeLayer:Boolean;
        private var m_didRemoveLayer:Boolean;
        private var m_layerBitmap:BitmapLayer;
    }
}