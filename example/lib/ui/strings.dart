import 'dart:ui';

import 'package:spa_scaffold/spa_scaffold.dart';


class Strings extends SpaStrings {

  // Main menu
  //
  late final String groupMenuItem1 = parse({
    'en': 'Group Menu Item 1',
    'pt': 'Item de Menu Grupo 1'
  });

  late final String actionMenuItem1 = parse({
    'en': 'Action Menu Item 1',
    'pt': 'Item de Menu Ação 1'
  });

  late final String groupMenuItem2 = parse({
    'en': 'Group Menu Item 2',
    'pt': 'Item de Menu Grupo 2'
  });

  late final String actionMenuItem2 = parse({
    'en': 'Action Menu Item 2',
    'pt': 'Item de Menu Ação 2'
  });


  // Page's titles
  //
  late final String pageTitle1 = parse({
    'en': "Page's Title 1",
    'pt': 'Título da Página 1'
  });

  late final String pageTitle2 = parse({
    'en': "Page's Title 2 - Large and Complete For Tests",
    'pt': 'Título da Página 2 - Grande e Completo Para Testes'
  });


  late final String newAction = parse({
    'en': 'New Action',
    'pt': 'Ação Novo'
  });

  late final String editAction = parse({
    'en': 'Edit Action',
    'pt': 'Ação Editar'
  });

  late final String deleteAction = parse({
    'en': 'Delete Action',
    'pt': 'Ação Deletar'
  });

  late final String disabledAction = parse({
    'en': 'Disabled Action',
    'pt': 'Ação Desativada'
  });

  Strings(Locale locale)
    :
    super(
      locale,
      appName: {
        'en': "Application's Name/Title",
        'pt': 'Nome/Título da Aplicação'
      },
      activePages: {
        'en': 'Open Pages',
        'pt': 'Páginas Abertas'
      },
      userPreferences: {
        'en': 'User Preferences',
        'pt': 'Preferências do Usuário'
      },
      loggedUser: {
        'en': 'Logged User',
        'pt': 'Usuário Logado'
      },
      process: {
        'en': 'Process',
        'pt': 'Processar'
      },
      print: {
        'en': 'Print',
        'pt': 'Imprimir'
      }
    );
}