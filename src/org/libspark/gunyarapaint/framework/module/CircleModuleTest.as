package org.libspark.gunyarapaint.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Logger;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public final class CircleModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = new Recorder(new Logger(new ByteArray()));
            var module:IDrawable = DrawModuleFactory.create(DrawModuleFactory.CIRCLE, recorder);
            Assert.assertEquals(module.name, DrawModuleFactory.CIRCLE);
        }
    }
}
