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

import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class NoJavaScriptLinkValidatorTest {
    NoJavaScriptLinkValidator validator = new NoJavaScriptLinkValidator();

    @Test
    public void GIVEN_null_object_WHEN_validate_THEN_is_valid() {
        assertTrue(validator.isValid(null, null));
    }

    @Test
    public void GIVEN_non_string_object_WHEN_validate_THEN_is_not_valid() {
        assertFalse(validator.isValid(5, null));
    }

    @Test
    public void GIVEN_safe_string_WHEN_validate_THEN_is_valid() {
        assertTrue(validator.isValid("https://example.com", null));
    }

    @Test
    public void GIVEN_unsafe_string_WHEN_validate_THEN_is_not_valid() {
        assertFalse(validator.isValid("javascript:('alert XSS')", null));
    }

    @Test
    public void GIVEN_unsafe_string_mixed_case_WHEN_validate_THEN_is_not_valid() {
        assertFalse(validator.isValid("JavaScript:('alert XSS')", null));
    }

}