package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.CompositeCommand;
    import com.github.niji.framework.commands.LineToCommand;
    import com.github.niji.framework.commands.MoveToCommand;
    import com.github.niji.framework.commands.PenCommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.ICanvasModule;
    import com.github.niji.framework.modules.TransparentLineModule;
    
    import flash.display.BlendMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public final class TransparentLineTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            m_recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(m_recorder);
            m_module = context.getModule(TransparentLineModule.TRANSPARENT_LINE);
        }
        
        [Test(description="TransparentLineModuleであること")]
        public function shouldBeTransparentLineModule():void
        {
            Assert.assertTrue(m_module is TransparentLineModule);
            Assert.assertEquals(m_module.name, TransparentLineModule.TRANSPARENT_LINE);
        }
        
        [Test(description="移動せずに描画すると何も起こならないがブレンドモードは復帰されること")]
        public function shouldDoNothingButRestoreBlendModeWithoutMoving():void
        {
            m_recorder.pen.blendMode = BlendMode.ADD;
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.assertCommands(Vector.<Class>([]), m_bytes);
            Assert.assertStrictlyEquals(BlendMode.ADD, m_recorder.pen.blendMode);
        }
        
        [Test(description="移動して描画すると5つのコマンドが実行された上でブレンドモードが復帰されること")]
        public function shouldExecuteFiveCommandsAndRestoreBlendModeWithMoving():void
        {
            var expected:Vector.<Class> = Vector.<Class>([
                PenCommand,
                MoveToCommand,
                LineToCommand,
                CompositeCommand,
                PenCommand
            ]);
            m_recorder.pen.blendMode = BlendMode.DARKEN;
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(expected, m_bytes);
            Assert.assertStrictlyEquals(BlendMode.DARKEN, m_recorder.pen.blendMode);
        }
        
        [Test(description="移動位置が保存されること")]
        public function shouldSaveCoordinates():void
        {
            ModuleTestUtil.assertLineSegment(m_module, true);
        }
        
        private var m_bytes:ByteArray;
        private var m_recorder:Recorder;
        private var m_module:ICanvasModule;
    }
}
