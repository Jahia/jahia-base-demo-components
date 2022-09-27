window.jahia.uiExtender.registry.add('callback', 'PDFPickerRegistration', {
    targets: ['jahiaApp-init:37'],
    callback: () => {
        window.jahia.uiExtender.registry.add('pickerConfiguration', 'pdf', {
            pickerInput: {
                emptyLabel: 'No PDF here',
                notFoundLabel: 'No PDF Found'
            },
            pickerDialog: {
                view: 'List',
                dialogTitle: 'Pick a PDF file',
                displayTree: true,
                displaySiteSwitcher: true,
                displaySearch: true
            },
            searchContentType: 'jnt:file',
            selectableTypesTable: ['jnt:file'],
            accordions: ['picker-media'],
            selectableFilter: [
                {
                    evaluation: 'CONTAINS',
                    fieldName: 'content.mimeType.value',
                    value: 'pdf'
                },
                {evaluation: 'EQUAL', fieldName: 'isFile', value: 'false'}
            ]
        });
    }
});
