// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Verificação de motoristas e gestão de envios';

  @override
  String get splashTagline => 'Você liga, nós transportamos!';

  @override
  String get onboardingTitle1Line1 => 'Logística inteligente.';

  @override
  String get onboardingTitle1Line2 => 'Conexões mais fortes.';

  @override
  String get onboardingSubtitle1 =>
      'Verificando motoristas. Gerenciando envios. Entregando confiança.';

  @override
  String get onboardingTitle2Line1 => 'Tudo o que você precisa,';

  @override
  String get onboardingTitle2Line2 => 'em um só lugar.';

  @override
  String get onboardingSubtitle2 =>
      'O app STT ajuda a verificar motoristas, rastrear envios e manter o controle a qualquer hora.';

  @override
  String get featureDriverTitle => 'Verificação do motorista';

  @override
  String get featureDriverBody =>
      'Verifique rapidamente os dados do motorista e o status STT.';

  @override
  String get featureShipmentTitle => 'Gestão de envios';

  @override
  String get featureShipmentBody =>
      'Crie, atualize, rastreie e gerencie todos os envios em tempo real.';

  @override
  String get featureRealtimeTitle => 'Atualizações em tempo real';

  @override
  String get featureRealtimeBody =>
      'Fique atualizado com o status ao vivo e tome decisões melhores.';

  @override
  String get getStarted => 'Começar';

  @override
  String get skip => 'Pular';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get chooseLanguage => 'Escolha seu idioma';

  @override
  String get chooseLanguageHint => 'Você pode alterar depois em Configurações.';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Configurações';

  @override
  String get notifications => 'Notificações';

  @override
  String get pushNotifications => 'Notificações push';

  @override
  String get pushNotificationsHint => 'Receba atualizações sobre seus envios';

  @override
  String get legal => 'Jurídico';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get termsOfUse => 'Termos de uso';

  @override
  String get appVersion => 'Versão do app';

  @override
  String get logout => 'Sair';

  @override
  String get confirmLogout => 'Confirmar saída';

  @override
  String get confirmLogoutBody => 'Tem certeza de que deseja sair?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get home => 'Início';

  @override
  String get shipments => 'Envios';

  @override
  String get profile => 'Perfil';

  @override
  String get fabTutorialTitle => 'Adicionar envio';

  @override
  String get fabTutorialBody =>
      'Toque no botão vermelho + para criar um envio.';

  @override
  String get fabTutorialGotIt => 'Entendi';

  @override
  String get navDone => 'Concluído';

  @override
  String get welcomeBack => 'Bem-vindo de volta';

  @override
  String get driverVerification => 'Verificação do motorista';

  @override
  String get tapCardForLicense => 'Toque no cartão para detalhes da carteira';

  @override
  String get completeProfileForLicense => 'Complete o perfil para ver o cartão';

  @override
  String get shipmentOverview => 'Visão geral dos envios';

  @override
  String get tapToOpenShipments => 'Toque para abrir envios';

  @override
  String get total => 'Total';

  @override
  String get statusPending => 'Pendente';

  @override
  String get statusInTransit => 'Em trânsito';

  @override
  String get statusDelivered => 'Entregue';

  @override
  String get sttVerified => 'Verificado STT';

  @override
  String get verificationPending => 'Pendente';

  @override
  String get verificationRejected => 'Rejeitado';

  @override
  String get addShipment => 'Adicionar envio';

  @override
  String get editShipment => 'Editar envio';

  @override
  String get deleteShipment => 'Excluir envio';

  @override
  String get noShipments => 'Ainda não há envios';

  @override
  String get createFirstShipment => 'Crie seu primeiro envio para começar';

  @override
  String get shipmentAdded => 'Envio adicionado com sucesso';

  @override
  String get shipmentDeleted => 'Envio excluído';

  @override
  String get shipmentUpdated => 'Envio atualizado';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Excluir envio $id?';
  }

  @override
  String get customerName => 'Nome do cliente';

  @override
  String get origin => 'Origem';

  @override
  String get destination => 'Destino';

  @override
  String get status => 'Status';

  @override
  String get updateShipment => 'Atualizar envio';

  @override
  String get saveShipment => 'Salvar envio';

  @override
  String get loginTitle => 'Entrar';

  @override
  String get emailHint => 'E-mail';

  @override
  String get passwordHint => 'Senha';

  @override
  String get loginButton => 'Entrar';

  @override
  String get loginSuccess => 'Login bem-sucedido';

  @override
  String get loginFailed => 'E-mail ou senha inválidos';

  @override
  String get logoutSuccess => 'Logout realizado';

  @override
  String get logoutFailed => 'Falha no logout';

  @override
  String get registerSuccess => 'Registro bem-sucedido';

  @override
  String get registerFailed => 'Falha no registro';

  @override
  String get registerTitle => 'Criar conta';

  @override
  String get registerButton => 'Criar conta';

  @override
  String get fullNameHint => 'Nome completo';

  @override
  String get phoneHint => 'Telefone';

  @override
  String get confirmPasswordHint => 'Confirmar senha';

  @override
  String get cdlHint => 'Número CDL';

  @override
  String get hubHint => 'Hub / depósito';

  @override
  String get dontHaveAccount => 'Não tem uma conta?';

  @override
  String get registerNow => 'Registrar agora';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get signInLink => 'Entrar';

  @override
  String get emailExists => 'Já existe uma conta com este e-mail';

  @override
  String get photoOptionalHint => 'Foto de perfil (opcional)';

  @override
  String get addPhotoHint => 'Toque para adicionar foto';

  @override
  String get changePhotoHint => 'Toque para alterar foto';

  @override
  String get profileUpdated => 'Perfil atualizado';

  @override
  String get fieldRequired => 'Este campo é obrigatório';

  @override
  String get invalidEmail => 'Digite um e-mail válido';

  @override
  String get invalidPhone => 'Digite um telefone válido';

  @override
  String get passwordTooShort => 'A senha deve ter pelo menos 6 caracteres';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get originSameAsDestination => 'Origem e destino devem ser diferentes';

  @override
  String get camera => 'Câmera';

  @override
  String get gallery => 'Galeria';

  @override
  String get removePhoto => 'Remover foto';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get driverProfileUnavailable => 'Perfil do motorista indisponível';
}
