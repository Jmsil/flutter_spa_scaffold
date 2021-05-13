import 'dart:ui';

import 'package:spa_scaffold/spa_scaffold.dart';


class AppStrings extends SpaStrings {

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


  late final String blueGrey = parse({
    'en': 'Blue Grey',
    'pt': 'Azul Cinza'
  });

  late final String blueGreyDark = parse({
    'en': 'Blue Grey Dark',
    'pt': 'Azul Cinza Escuro'
  });

  late final String english = parse({
    'en': 'English',
    'pt': 'Inglês'
  });

  late final String portuguese = parse({
    'en': 'Portuguese',
    'pt': 'Português'
  });


  AppStrings(Locale locale)
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
      },
      floatingPanels: {
        'en': 'Floating Panels',
        'pt': 'Painéis Flutuantes'
      },
      headersShadow: {
        'en': 'Headers Shadow',
        'pt': 'Cabeçalhos Com Sombra'
      },
      panelsDecorImage: {
        'en': 'Panels Decor Image',
        'pt': 'Painéis Com Decoração'
      },
      success: {
        'en': 'Success',
        'pt': 'Sucesso'
      },
      error: {
        'en': 'Error',
        'pt': 'Erro'
      },
      invalidData: {
        'en': 'Invalid Data',
        'pt': 'Dado Inválido'
      },
      recordSuccessMessage: {
        'en': 'Registry recorded successfully.',
        'pt': 'Registro gravado com sucesso.'
      },
      recordErrorMessage: {
        'en': 'An error has occurred while recording.',
        'pt': 'Ocorreu um erro ao gravar o registro.'
      },
      editCancelQuestion: {
        'en': 'Are you sure you want to cancel the editing?',
        'pt': 'Você tem certeza que deseja cancelar a edição?'
      },
      editDeleteQuestion: {
        'en': 'Are you sure you want to delete the registry?',
        'pt': 'Você tem certeza que deseja deletar o registro?'
      },
      deleteSuccessMessage: {
        'en': 'Registry deleted successfully.',
        'pt': 'Registro deletado com sucesso.'
      },
      deleteErrorMessage: {
        'en': 'An error has occurred while deleting.',
        'pt': 'Ocorreu um erro ao deletar o registro.'
      },
      noData: {
        'en': 'No Data',
        'pt': 'Sem Dados'
      },
      noDataFound: {
        'en': 'No data found.',
        'pt': 'Nenhum dado encontrado.'
      },
      theme: {
        'en': 'Theme',
        'pt': 'Tema'
      },
      language: {
        'en': 'Language',
        'pt': 'Idioma'
      }
    );
}

extension AppSettings on SpaSettingsModel {
  AppStrings get appStrings => strings as AppStrings;
}