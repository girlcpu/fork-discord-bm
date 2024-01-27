
/// https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes
@UnstableEnum<String>
public enum OAuth2Scope: Sendable, Codable {
    case activitiesRead // "activities.read"
    case activitiesWrite // "activities.write"
    case applicationsBuildsRead // "applications.builds.read"
    case applicationsBuildsUpload // "applications.builds.upload"
    case applicationsCommands // "applications.commands"
    case applicationsCommandsUpdate // "applications.commands.update"
    case applicationsCommandsPermissionsUpdate // "applications.commands.permissions.update"
    case applicationsEntitlements // "applications.entitlements"
    case applicationsStoreUpdate // "applications.store.update"
    case bot // "bot"
    case connections // "connections"
    case DMChannelsRead // "dm_channels.read"
    case email // "email"
    case GDMJoin // "gdm.join"
    case guilds // "guilds"
    case guildsJoin // "guilds.join"
    case guildsMembersRead // "guilds.members.read"
    case identify // "identify"
    case messagesRead // "messages.read"
    case relationshipsRead // "relationships.read"
    case rpc // "rpc"
    case rpcActivitiesWrite // "rpc.activities.write"
    case rpcNotificationsRead // "rpc.notifications.read"
    case rpcVoiceRead // "rpc.voice.read"
    case rpcVoiceWrite // "rpc.voice.write"
    case voice // "voice"
    case webhookIncoming // "webhook.incoming"
    case _undocumented(String)
}
