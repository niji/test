package org.libspark.gunyarapaint.framework
{
    import flash.display.Shape;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import org.libspark.gunyarapaint.framework.PaintEngine;
    import org.libspark.gunyarapaint.framework.Pen;

    public class FakePaintEngine extends PaintEngine
    {
        public function FakePaintEngine()
        {
            super(new Shape());
            reset();
        }
        
        public function reset():void
        {
            cleared = false;
            filled = false;
            point = new Point();
            rectangle = new Rectangle();
            radius = 0.0;
        }
        
        override public function drawCircle(rad:Number):void
        {
            radius = rad;
        }
        
        override public function drawRect(x:Number,
                                          y:Number,
                                          width:uint,
                                          height:uint):void
        {
            rectangle = new Rectangle(x, y, width, height);
        }
        
        override public function drawEllipse(x:Number,
                                             y:Number,
                                             width:uint,
                                             height:uint):void
        {
            rectangle = new Rectangle(x, y, width, height);
        }
        
        override public function beginFill(c:uint, a:Number):void
        {
            color = c;
            alpha = a;
        }
        
        override public function endFill():void
        {
            filled = true;
        }
        
        override public function lineTo(x:Number, y:Number):void
        {
            point = new Point(x, y);
        }
        
        override public function moveTo(x:Number, y:Number):void
        {
            point = new Point(x, y);
        }
        
        public static var cleared:Boolean;
        public static var filled:Boolean;
        public static var point:Point;
        public static var rectangle:Rectangle;
        public static var radius:Number;
        public static var color:uint;
        public static var alpha:Number;
    }
}
