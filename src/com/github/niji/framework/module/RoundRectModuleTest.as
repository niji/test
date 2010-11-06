package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.ICanvasModule;
    import com.github.niji.framework.modules.RoundRectModule;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public final class RoundRectModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(RoundRectModule.ROUND_RECT);
        }
        
        [Test(description="RoundRectModuleであること")]
        public function shouldBeRoundRectModule():void
        {
            Assert.assertTrue(m_module is RoundRectModule);
            Assert.assertEquals(m_module.name, RoundRectModule.ROUND_RECT);
        }
        
        [Test(description="移動せずに描画すると何も起こらないこと")]
        public function shouldDoNothingWithoutMoving():void
        {
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.assertCommands(Vector.<Class>([]), m_bytes);
        }
        
        [Test(description="移動位置が保存されること")]
        public function shouldSaveCoordinates():void
        {
            ModuleTestUtil.assertLineSegment(m_module, true);
        }
        
        private var m_bytes:ByteArray;
        private var m_module:ICanvasModule;
    }
}
