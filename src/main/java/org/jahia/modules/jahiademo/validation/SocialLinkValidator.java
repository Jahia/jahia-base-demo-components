/*
 * ==========================================================================================
 * =                            JAHIA'S ENTERPRISE DISTRIBUTION                             =
 * ==========================================================================================
 *
 *                                  http://www.jahia.com
 *
 * JAHIA'S ENTERPRISE DISTRIBUTIONS LICENSING - IMPORTANT INFORMATION
 * ==========================================================================================
 *
 *     Copyright (C) 2002-2025 Jahia Solutions Group. All rights reserved.
 *
 *     This file is part of a Jahia's Enterprise Distribution.
 *
 *     Jahia's Enterprise Distributions must be used in accordance with the terms
 *     contained in the Jahia Solutions Group Terms &amp; Conditions as well as
 *     the Jahia Sustainable Enterprise License (JSEL).
 *
 *     For questions regarding licensing, support, production usage...
 *     please contact our team at sales@jahia.com or go to http://www.jahia.com/license.
 *
 * ==========================================================================================
 */
package org.jahia.modules.jahiademo.validation;

import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.decorator.validation.JCRNodeValidator;

public class SocialLinkValidator implements JCRNodeValidator {
    JCRNodeWrapper node;

    public SocialLinkValidator(JCRNodeWrapper node) {
        this.node = node;
    }

    @NoJavaScriptLink
    public String getFacebook() {
        return node.getPropertyAsString("facebook");
    }

    @NoJavaScriptLink
    public String getGooglePlus() {
        return node.getPropertyAsString("googlePlus");
    }

    @NoJavaScriptLink
    public String getLinkedIn() {
        return node.getPropertyAsString("linkedIn");
    }

    @NoJavaScriptLink
    public String getTwitter() {
        return node.getPropertyAsString("twitter");
    }

}
