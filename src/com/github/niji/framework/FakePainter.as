package com.github.niji.framework
{
    import flash.display.BlendMode;
    import flash.geom.Point;
    
	/**
	 * Painter を継承するスタブクラス。実行したかのフラグ管理及び代入された値、描写位置を担当する。
	 * 
	 * コマンドのテストで使う。巻き戻し及びやり直しをしたかについては例外でインスタンスから呼び出す必要がある。
	 * これは単にそうしたほうが楽だからという事情である。
	 * FakeLayerBitmapCollection と同じく、インターフェース実装が望ましいのだが、
	 * 再設計が必要になるので仕方なく継承とした。
	 */	
    public class FakePainter extends Painter
    {
        public function FakePainter()
        {
            var engine:FakePaintEngine = new FakePaintEngine();
            super(1, 1, Version.LOG_VERSION, engine);
            m_didComposite = false;
            m_didFloodFill = false;
            m_didStartDrawing = false;
            m_didEndDrawing = false;
            m_coordinate = new Point();
            m_layerIndex = 0;
            m_layerVisible = true;
            m_layerAlpha = 0.0;
            m_layerBlendMode = BlendMode.NORMAL;
            m_layers = new FakeLayerList(1, 1);
            m_didUndo = false;
            m_didRedo = false;
            m_didPushUndo = false;
            m_didPushUndoIfNeed = false;
            m_paintEngine = engine;
        }
        
        public override function undo():void
        {
            m_didUndo = true;
        }
        
        public override function redo():void
        {
            m_didRedo = true;
        }
        
        public override function pushUndo():void
        {
            m_didPushUndo = true;
        }
        
        public override function pushUndoIfNeed():void
        {
            m_didPushUndoIfNeed = true;
        }
        
        public override function composite():void
        {
            m_didComposite = true;
        }
        
        public override function floodFill():void
        {
            m_didFloodFill = true;
        }
        
        public override function setPixel(x:int, y:int):void
        {
            m_coordinate = new Point(x, y);
        }
        
        public override function setVisibleAt(index:int, visible:Boolean):void
        {
            m_layerIndex = index;
            m_layerVisible = visible;
        }
        
        public override function transformWithHorizontalMirrorAt(index:int):void
        {
            m_layerIndex = index;
        }
        
        public override function transformWithVerticalMirrorAt(index:int):void
        {
            m_layerIndex = index;
        }
        
        public override function move(x:int, y:int):void
        {
            m_coordinate = new Point(x, y);
        }
        
        public override function scale(x:int, y:int):void
        {
            m_coordinate = new Point(x, y);
        }
        
        public override function startDrawing():void
        {
            m_didStartDrawing = true;
        }
        
        public override function stopDrawing():void
        {
            m_didEndDrawing = true;
        }
        
        public function get didUndo():Boolean
        {
            return m_didUndo;
        }
        
        public function get didRedo():Boolean
        {
            return m_didRedo;
        }
        
        public function get didPushUndo():Boolean
        {
            return m_didPushUndo && !m_didPushUndoIfNeed;
        }
        
        public function get didPushUndoIfNeed():Boolean
        {
            return m_didPushUndoIfNeed && !m_didPushUndo;
        }
        
        public override function set currentLayerAlpha(alpha:Number):void
        {
            m_layerAlpha = alpha;
        }
        
        public override function set currentLayerBlendMode(blendMode:String):void
        {
            m_layerBlendMode = blendMode;
        }
        
        public function get didComposite():Boolean
        {
            return m_didComposite;
        }
        
        public function get didFloodFill():Boolean
        {
            return m_didFloodFill;
        }
        
        public function get point():Point
        {
            return m_coordinate;
        }
        
        public function get layerIndex():int
        {
            return m_layerIndex;
        }
        
        public function get layerVisible():Boolean
        {
            return m_layerVisible;
        }
        
        public function get didStartDrawing():Boolean
        {
            return m_didStartDrawing;
        }
        
        public function get didEndDrawing():Boolean
        {
            return m_didEndDrawing;
        }
        
        public function get layerAlpha():Number
        {
            return m_layerAlpha;
        }
        
        public function get layerBlendMode():String
        {
            return m_layerBlendMode;
        }
        
        public function get fakePaintEngine():FakePaintEngine
        {
            return m_paintEngine;
        }
        
        private var m_didComposite:Boolean;
        private var m_didFloodFill:Boolean;
        private var m_coordinate:Point;
        private var m_layerIndex:int;
        private var m_layerVisible:Boolean;
        private var m_didStartDrawing:Boolean;
        private var m_didEndDrawing:Boolean;
        private var m_layerAlpha:Number;
        private var m_layerBlendMode:String;
        private var m_paintEngine:FakePaintEngine;
        private var m_didUndo:Boolean;
        private var m_didRedo:Boolean;
        private var m_didPushUndo:Boolean;
        private var m_didPushUndoIfNeed:Boolean;
    }
}