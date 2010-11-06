package com.github.niji.framework
{
    import flash.display.Shape;
    import flash.geom.Point;
    import flash.geom.Rectangle;

	/**
	 * PaintEngine を継承したスタブクラス。実行したかのフラグ及び描写位置を管理する。FakePainter に包括される。
	 * 
	 * もともと PaintEngine を作ったきっかけは flash.display.Graphics がサブクラスとして作れないので、
	 * これをラップするクラスを必要としたため。PaintEngine のおかげで少なくとも実行したかのテストは出来るようになった。
	 */	
    public class FakePaintEngine extends PaintEngine
    {
        public function FakePaintEngine()
        {
            super(new Shape());
            reset();
        }
        
        public function reset():void
        {
            m_cleared = false;
            m_filled = false;
            m_point = new Point();
            m_rectangle = new Rectangle();
            m_radius = 0.0;
        }
        
        override public function drawCircle(rad:Number):void
        {
            m_radius = rad;
        }
        
        override public function drawRect(width:int,
                                          height:int):void
        {
            m_rectangle = new Rectangle(0, 0, width, height);
        }
        
        override public function drawEllipse(width:uint,
                                             height:uint):void
        {
            m_rectangle = new Rectangle(0, 0, width, height);
        }
        
        override public function beginFill(c:uint, a:Number):void
        {
            m_color = c;
            m_alpha = a;
        }
        
        override public function endFill():void
        {
            m_filled = true;
        }
        
        override public function lineTo(x:Number, y:Number):void
        {
            m_point = new Point(x, y);
        }
        
        override public function moveTo(x:Number, y:Number):void
        {
            m_point = new Point(x, y);
        }
        
        public function get cleared():Boolean
        {
            return m_cleared;
        }
        
        public function get filled():Boolean
        {
            return m_filled;
        }
        
        public function get point():Point
        {
            return m_point;
        }
        
        public function get rectangle():Rectangle
        {
            return m_rectangle;
        }
        
        public function get radius():Number
        {
            return m_radius;
        }
        
        public function get color():uint
        {
            return m_color;
        }
        
        public function get alpha():Number
        {
            return m_alpha;
        }
        
        private var m_cleared:Boolean;
        private var m_filled:Boolean;
        private var m_point:Point;
        private var m_rectangle:Rectangle;
        private var m_radius:Number;
        private var m_color:uint;
        private var m_alpha:Number;
    }
}
