import 'dart:ui';

import 'package:spa_scaffold/spa_scaffold.dart';


class Strings extends SpaStrings {

  // Main menu
  //
  late final String groupMenuItem1 = parse({
    'en': 'Registrations Menu',
    'pt': 'Menu de Cadastros'
  });

  late final String actionMenuItem1 = parse({
    'en': 'Registration Page',
    'pt': 'Página de Cadastro'
  });

  late final String groupMenuItem2 = parse({
    'en': 'Reports Menu',
    'pt': 'Menu de Relatórios'
  });

  late final String actionMenuItem2 = parse({
    'en': 'Report Page',
    'pt': 'Página de Relatório'
  });


  // Page's titles
  //
  late final String pageTitle1 = parse({
    'en': "Registration Page's Title",
    'pt': 'Título da Página de Cadastro'
  });


  late final String pageTitle2 = parse({
    'en': "Report Page's Title",
    'pt': 'Título da Página de Relatório'
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
      loggedUser: {
        'en': 'Logged User',
        'pt': 'Usuário Logado'
      },
      userPreferences: {
        'en': 'User Preferences',
        'pt': 'Preferências do Usuário'
      },
      process: {
        'en': 'Process',
        'pt': 'Processar'
      },
      print: {
        'en': 'Print',
        'pt': 'Imprimir'
      },
      record: {
        'en': 'Record',
        'pt': 'Gravar'
      },
      cancel: {
        'en': 'Cancel',
        'pt': 'Cancelar'
      },
      delete: {
        'en': 'Delete',
        'pt': 'Deletar'
      },
      ok: {
        'en': 'Ok',
        'pt': 'Ok'
      },
      yes: {
        'en': 'Yes',
        'pt': 'Sim'
      },
      no: {
        'en': 'No',
        'pt': 'Não'
      }
    );
}