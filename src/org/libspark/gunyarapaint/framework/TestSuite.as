package org.libspark.gunyarapaint.framework
{
    import org.libspark.gunyarapaint.framework.commands.BeginFillCommandTest;
    import org.libspark.gunyarapaint.framework.commands.CompositeCommandTest;
    import org.libspark.gunyarapaint.framework.commands.DrawCircleCommandTest;
    import org.libspark.gunyarapaint.framework.commands.EndFillComamndTest;
    import org.libspark.gunyarapaint.framework.commands.FloodFillCommandTest;
    import org.libspark.gunyarapaint.framework.commands.HorizontalMirrorCommandTest;
    import org.libspark.gunyarapaint.framework.commands.LineToCommandTest;
    import org.libspark.gunyarapaint.framework.commands.MoveToCommandTest;
    import org.libspark.gunyarapaint.framework.commands.PenCommandTest;
    import org.libspark.gunyarapaint.framework.commands.PixelCommandTest;
    import org.libspark.gunyarapaint.framework.commands.RedoCommandTest;
    import org.libspark.gunyarapaint.framework.commands.UndoCommandTest;
    import org.libspark.gunyarapaint.framework.commands.VerticalMirrorCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.CopyLayerCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.CreateLayerCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.MergeLayerCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.RemoveLayerCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerAlphaCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerBlendModeCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerIndexCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.SetLayerVisibleCommandTest;
    import org.libspark.gunyarapaint.framework.commands.layer.SwapLayerCommandTest;
    import org.libspark.gunyarapaint.framework.module.CircleModuleTest;
    import org.libspark.gunyarapaint.framework.module.DropperModuleTest;
    import org.libspark.gunyarapaint.framework.module.EllipseModuleTest;
    import org.libspark.gunyarapaint.framework.module.EraserModuleTest;
    import org.libspark.gunyarapaint.framework.module.FloodFillModuleTest;
    import org.libspark.gunyarapaint.framework.module.FreeHandModuleTest;
    import org.libspark.gunyarapaint.framework.module.LineModuleTest;
    import org.libspark.gunyarapaint.framework.module.PixelModuleTest;
    import org.libspark.gunyarapaint.framework.module.RectModuleTest;
    import org.libspark.gunyarapaint.framework.module.RoundRectModuleTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class TestSuite
    {
        public var copyLayerCommand:CopyLayerCommandTest;
        
        public var createLayerCommand:CreateLayerCommandTest;
        
        public var mergeLayerCommand:MergeLayerCommandTest;
        
        public var removeLayerCommand:RemoveLayerCommandTest;
        
        public var setLayerAlphaCommand:SetLayerAlphaCommandTest;
        
        public var setLayerBlendModeCommand:SetLayerBlendModeCommandTest;
        
        public var setLayerIndexCommand:SetLayerIndexCommandTest;
        
        public var setLayerVisibleCommand:SetLayerVisibleCommandTest;
        
        public var swapLayerCommand:SwapLayerCommandTest;
        
        public var beginFillCommand:BeginFillCommandTest;
        
        public var compositeCommand:CompositeCommandTest;
        
        public var drawCircleCommand:DrawCircleCommandTest;
        
        public var endFillCommand:EndFillComamndTest;
        
        public var floodFillCommand:FloodFillCommandTest;
        
        public var horizontalMirrorCommand:HorizontalMirrorCommandTest;
        
        public var lineToCommand:LineToCommandTest
        
        public var moveToCommand:MoveToCommandTest
        
        public var penCommand:PenCommandTest;
        
        public var pixelCommand:PixelCommandTest;
        
        public var redoCommand:RedoCommandTest;
        
        public var undoCommand:UndoCommandTest;
        
        public var verticalMirrorCommand:VerticalMirrorCommandTest;
        
        public var circleModule:CircleModuleTest;
        
        public var dropperModule:DropperModuleTest;
        
        public var ellipseModule:EllipseModuleTest;
        
        public var eraserModule:EraserModuleTest;
        
        public var floodFill:FloodFillModuleTest;
        
        public var freeHandModule:FreeHandModuleTest;
        
        public var lineModule:LineModuleTest;
        
        public var pixelModule:PixelModuleTest;
        
        public var rectModule:RectModuleTest;
        
        public var roundRectModule:RoundRectModuleTest;
        
        public var layerBitmapContainer:LayerBitmapContainerTest;
        
        public var layerBitmap:LayerBitmapTest;
        
        public var painter:PainterTest;
        
        public var parser:ParserTest;
        
        public var player:PlayerTest;
        
        public var undo:UndoStackTest;
    }
}
