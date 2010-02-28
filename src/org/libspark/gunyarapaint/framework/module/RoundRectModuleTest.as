package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public class RoundRectModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = new Recorder();
            var module:IDrawable = DrawModuleFactory.create(DrawModuleFactory.ROUND_RECT, recorder);
            Assert.assertEquals(module.name, DrawModuleFactory.ROUND_RECT);
        }
    }
}
