
window.jahia.i18n.loadNamespaces('dx-base-demo-components');

window.jahia.uiExtender.registry.add('callback', 'dx-base-demo-components', {
    targets: ['jahiaApp-init:80'],
    callback: function () {
        window.jahia.uiExtender.registry.add('pickerConfiguration', 'demoInternalLink', {
            searchContentType: 'jmix:searchable',
            selectableTypesTable: ['jmix:droppableContent', 'jnt:page', 'jnt:contentFolder', 'jnt:folder'],
            defaultViewMode: 'structuredView'
        });

        // Re-use 'editorial' picker accordionItems
        const registryType = 'accordionItem';
        const accordionItems = window.jahia.uiExtender.registry.find({type: registryType, target: 'editorial'});
        for (const item of accordionItems) {
            window.jahia.uiExtender.registry.addOrReplace(registryType, item.key, item, {targets: ['demoInternalLink:80']});
        }
    }
});
