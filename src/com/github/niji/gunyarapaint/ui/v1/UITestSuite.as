package com.github.niji.gunyarapaint.ui.v1
{
    import com.github.niji.gunyarapaint.ui.v1.i18n.GetTextTranslatorTest;
    import com.github.niji.gunyarapaint.ui.v1.net.ParametersTest;
    import com.github.niji.gunyarapaint.ui.v1.net.RequestTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class UITestSuite
    {
        public var gettext:GetTextTranslatorTest;
        
        public var parameters:ParametersTest;
        
        public var request:RequestTest;
    }
}
