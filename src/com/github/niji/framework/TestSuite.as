package com.github.niji.framework
{
    import com.github.niji.framework.commands.BeginFillCommandTest;
    import com.github.niji.framework.commands.BezierCurveCommandTest;
    import com.github.niji.framework.commands.CompatibilityCommandTest;
    import com.github.niji.framework.commands.CompositeCommandTest;
    import com.github.niji.framework.commands.DrawCircleCommandTest;
    import com.github.niji.framework.commands.EndFillComamndTest;
    import com.github.niji.framework.commands.FloodFillCommandTest;
    import com.github.niji.framework.commands.HorizontalMirrorCommandTest;
    import com.github.niji.framework.commands.LineToCommandTest;
    import com.github.niji.framework.commands.MoveToCommandTest;
    import com.github.niji.framework.commands.PenCommandTest;
    import com.github.niji.framework.commands.PixelCommandTest;
    import com.github.niji.framework.commands.RedoCommandTest;
    import com.github.niji.framework.commands.ResetAllCommandTest;
    import com.github.niji.framework.commands.UndoCommandTest;
    import com.github.niji.framework.commands.VerticalMirrorCommandTest;
    import com.github.niji.framework.commands.layer.CopyLayerCommandTest;
    import com.github.niji.framework.commands.layer.CreateLayerCommandTest;
    import com.github.niji.framework.commands.layer.MergeLayerCommandTest;
    import com.github.niji.framework.commands.layer.MoveLayerCommandTest;
    import com.github.niji.framework.commands.layer.RemoveLayerCommandTest;
    import com.github.niji.framework.commands.layer.ScaleLayerCommandTest;
    import com.github.niji.framework.commands.layer.SetLayerAlphaCommandTest;
    import com.github.niji.framework.commands.layer.SetLayerBlendModeCommandTest;
    import com.github.niji.framework.commands.layer.SetLayerIndexCommandTest;
    import com.github.niji.framework.commands.layer.SetLayerVisibleCommandTest;
    import com.github.niji.framework.commands.layer.SwapLayerCommandTest;
    import com.github.niji.framework.i18n.TranslatorTest;
    import com.github.niji.framework.module.CircleModuleTest;
    import com.github.niji.framework.module.DropperModuleTest;
    import com.github.niji.framework.module.EllipseModuleTest;
    import com.github.niji.framework.module.FloodFillModuleTest;
    import com.github.niji.framework.module.FreeHandModuleTest;
    import com.github.niji.framework.module.LineModuleTest;
    import com.github.niji.framework.module.PixelModuleTest;
    import com.github.niji.framework.module.RectModuleTest;
    import com.github.niji.framework.module.RoundRectModuleTest;
    import com.github.niji.framework.module.TransparentFloodFillTest;
    import com.github.niji.framework.module.TransparentLineTest;
    import com.github.niji.framework.modules.TransparentLineModule;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class TestSuite
    {
        public var bezierCurveCommand:BezierCurveCommandTest;
        
        public var copyLayerCommand:CopyLayerCommandTest;
        
        public var createLayerCommand:CreateLayerCommandTest;
        
        public var mergeLayerCommand:MergeLayerCommandTest;
        
        public var moveLayerCommand:MoveLayerCommandTest;
        
        public var removeLayerCommand:RemoveLayerCommandTest;
        
        public var scaleLayerCommand:ScaleLayerCommandTest;
        
        public var setLayerAlphaCommand:SetLayerAlphaCommandTest;
        
        public var setLayerBlendModeCommand:SetLayerBlendModeCommandTest;
        
        public var setLayerIndexCommand:SetLayerIndexCommandTest;
        
        public var setLayerVisibleCommand:SetLayerVisibleCommandTest;
        
        public var swapLayerCommand:SwapLayerCommandTest;
        
        public var beginFillCommand:BeginFillCommandTest;
        
        public var compatibilityCommand:CompatibilityCommandTest;
        
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
        
        public var resetAllCommand:ResetAllCommandTest;
        
        public var undoCommand:UndoCommandTest;
        
        public var verticalMirrorCommand:VerticalMirrorCommandTest;
        
        public var translator:TranslatorTest;
        
        public var circleModule:CircleModuleTest;
        
        public var dropperModule:DropperModuleTest;
        
        public var ellipseModule:EllipseModuleTest;
        
        public var floodFill:FloodFillModuleTest;
        
        public var freeHandModule:FreeHandModuleTest;
        
        public var lineModule:LineModuleTest;
        
        public var pixelModule:PixelModuleTest;
        
        public var rectModule:RectModuleTest;
        
        public var roundRectModule:RoundRectModuleTest;
        
        public var transparentFloodFillModule:TransparentFloodFillTest;
        
        public var transparentLineModule:TransparentLineTest;
        
        public var layerBitmapContainer:LayerContainerTest;
        
        public var layerBitmap:BitmapLayerTest;
        
        public var marshal:MarshalTest;
        
        public var painter:PainterTest;
        
        public var parser:ParserTest;
        
        public var player:PlayerTest;
        
        public var recorder:RecorderTest;
        
        public var undoStack:UndoStackTest;
        
        public var version:VersionTest;
    }
}
