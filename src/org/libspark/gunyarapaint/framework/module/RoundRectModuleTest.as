package org.libspark.gunyarapaint.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;
    import org.libspark.gunyarapaint.framework.modules.RoundRectModule;

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
        
        [Test]
        public function isRoundRectModule():void
        {
            Assert.assertTrue(m_module is RoundRectModule);
            Assert.assertEquals(m_module.name, RoundRectModule.ROUND_RECT);
        }
        
        [Test]
        public function drawWithoutMoving():void
        {
            m_module.start(1, 1);
            m_module.stop(1, 1);
            var commands:Vector.<ICommand> = ModuleTestUtil.getCommands(m_bytes);
            Assert.assertEquals(0, commands.length);
        }
        
        [Test]
        public function drawWithMoving():void
        {
        }
        
        private var m_bytes:ByteArray;
        private var m_module:ICanvasModule;
    }
}
