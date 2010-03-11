package org.libspark.gunyarapaint.framework
{
    import flash.display.BlendMode;
    import flash.geom.Point;
    
    public class FakeCanvasContext extends Painter
    {
        public function FakeCanvasContext()
        {
            didComposite = false;
            didFloodFill = false;
            didStartDrawing = false;
            didEndDrawing = false;
            coordinate = new Point();
            layerIndex = 0;
            layerVisible = true;
            layerAlpha = 0.0;
            layerBlendMode = BlendMode.NORMAL;
            fakePaintEngine = new FakePaintEngine();
            super(1, 1, PAINTER_LOG_VERSION, fakePaintEngine);
            m_layers = new FakeLayerBitmapCollection(1, 1);
            m_didUndo = false;
            m_didRedo = false;
            m_didPushUndo = false;
            m_didPushUndoIfNeed = false;
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
            didComposite = true;
        }
        
        public override function floodFill():void
        {
            didFloodFill = true;
        }
        
        public override function setPixel(x:int, y:int):void
        {
            coordinate = new Point(x, y);
        }
        
        public override function setVisibleAt(index:int, visible:Boolean):void
        {
            layerIndex = index;
            layerVisible = visible;
        }
        
        public override function transformWithHorizontalMirrorAt(index:int):void
        {
            layerIndex = index;
        }
        
        public override function transformWithVerticalMirrorAt(index:int):void
        {
            layerIndex = index;
        }
        
        public override function startDrawingSession():void
        {
            didStartDrawing = true;
        }
        
        public override function stopDrawingSession():void
        {
            didEndDrawing = true;
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
            return m_didPushUndo;
        }
        
        public function get didPushUndoIfNeed():Boolean
        {
            return m_didPushUndoIfNeed;
        }
        
        public override function set currentLayerAlpha(alpha:Number):void
        {
            layerAlpha = alpha;
        }
        
        public override function set currentLayerBlendMode(blendMode:String):void
        {
            layerBlendMode = blendMode;
        }
        
        public static var didComposite:Boolean;
        public static var didFloodFill:Boolean;
        public static var coordinate:Point;
        public static var layerIndex:int;
        public static var layerVisible:Boolean;
        public static var didStartDrawing:Boolean;
        public static var didEndDrawing:Boolean;
        public static var layerAlpha:Number;
        public static var layerBlendMode:String;
        public static var fakePaintEngine:FakePaintEngine;
        private var m_didUndo:Boolean;
        private var m_didRedo:Boolean;
        private var m_didPushUndo:Boolean;
        private var m_didPushUndoIfNeed:Boolean;
    }
}