package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.FloodFillModule;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;

    public class FloodFillModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            var module:ICanvasModule = context.getModule(FloodFillModule.FLOOD_FILL);
            Assert.assertTrue(module is FloodFillModule);
            Assert.assertEquals(module.name, FloodFillModule.FLOOD_FILL);
        }
    }
}
